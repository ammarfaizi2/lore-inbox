Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932207AbWG3KON@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932207AbWG3KON (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 06:14:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932229AbWG3KON
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 06:14:13 -0400
Received: from abfb156.neoplus.adsl.tpnet.pl ([83.7.39.156]:11968 "EHLO
	pcserwis") by vger.kernel.org with ESMTP id S932211AbWG3KOL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 06:14:11 -0400
Date: Sun, 30 Jul 2006 12:13:47 +0200
To: "David Masover" <ninja@slaphack.com>, LKML <linux-kernel@vger.kernel.org>,
       "reiserfs-list@namesys.com" <reiserfs-list@namesys.com>
Subject: Re: metadata plugins (was Re: the " 'official' point of view" expressed by kernelnewbies.org regarding reiser4 inclusion)
From: =?iso-8859-2?B?o3VrYXN6IE1pZXJ6d2E=?= <prymitive@pcserwis.hopto.org>
Organization: PC Serwis
Content-Type: text/plain; format=flowed; delsp=yes; charset=iso-8859-2
MIME-Version: 1.0
References: <200607281402.k6SE245v004715@laptop13.inf.utfsm.cl> <44CA31D2.70203@slaphack.com> <Pine.LNX.4.64.0607280859380.4168@g5.osdl.org> <44C9FB93.9040201@namesys.com> <44CA6905.4050002@slaphack.com> <44CA126C.7050403@namesys.com> <44CA8771.1040708@slaphack.com> <44CABB87.3050509@namesys.com> <17611.21640.208153.492074@gargle.gargle.HOWL> <44CBA99F.2040306@slaphack.com>
Content-Transfer-Encoding: 8bit
Message-ID: <op.tdhyo9utd4os1z@localhost>
In-Reply-To: <44CBA99F.2040306@slaphack.com>
User-Agent: Opera Mail/9.00 (Linux)
X-PCSerwis-MailScanner-Information: Please contact the ISP for more information
X-PCSerwis-MailScanner: Found to be clean
X-PCSerwis-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-15.006, required 6, autolearn=not spam, ALL_TRUSTED -1.80,
	AWL 1.79, BAYES_00 -15.00)
X-MailScanner-From: prymitive@pcserwis.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dnia Sat, 29 Jul 2006 20:31:59 +0200, David Masover <ninja@slaphack.com>  
napisa³:

> Nikita Danilov wrote:
>
>> As you see, ext2 code already has multiple file "plugins", with
>> persistent "plugin id" (stored in i_mode field of on-disk struct
>> ext2_inode).
>
> Aha!  So here's another question:  Is it fair to ask Reiser4 to make its
> plugins generic, or should we be asking ext2/3 first?
>

Doesn't iptables have plugins? Maybe we should make them generic so other  
packet filters can use them ;)
