Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932331AbWG3Pde@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932331AbWG3Pde (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 11:33:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932335AbWG3Pde
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 11:33:34 -0400
Received: from 63-162-81-179.lisco.net ([63.162.81.179]:42886 "EHLO
	grunt.slaphack.com") by vger.kernel.org with ESMTP id S932331AbWG3Pdd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 11:33:33 -0400
Message-ID: <44CCD145.1040801@slaphack.com>
Date: Sun, 30 Jul 2006 10:33:25 -0500
From: David Masover <ninja@slaphack.com>
User-Agent: Thunderbird 1.5.0.5 (Macintosh/20060719)
MIME-Version: 1.0
To: =?ISO-8859-2?Q?=A3ukasz_Mierzwa?= <prymitive@pcserwis.hopto.org>
CC: LKML <linux-kernel@vger.kernel.org>,
       "reiserfs-list@namesys.com" <reiserfs-list@namesys.com>
Subject: Re: metadata plugins (was Re: the " 'official' point of view" expressed
 by kernelnewbies.org regarding reiser4 inclusion)
References: <200607281402.k6SE245v004715@laptop13.inf.utfsm.cl> <44CA31D2.70203@slaphack.com> <Pine.LNX.4.64.0607280859380.4168@g5.osdl.org> <44C9FB93.9040201@namesys.com> <44CA6905.4050002@slaphack.com> <44CA126C.7050403@namesys.com> <44CA8771.1040708@slaphack.com> <44CABB87.3050509@namesys.com> <17611.21640.208153.492074@gargle.gargle.HOWL> <44CBA99F.2040306@slaphack.com> <op.tdhyo9utd4os1z@localhost>
In-Reply-To: <op.tdhyo9utd4os1z@localhost>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

£ukasz Mierzwa wrote:
> Dnia Sat, 29 Jul 2006 20:31:59 +0200, David Masover <ninja@slaphack.com> 
> napisa³:
> 
>> Nikita Danilov wrote:
>>
>>> As you see, ext2 code already has multiple file "plugins", with
>>> persistent "plugin id" (stored in i_mode field of on-disk struct
>>> ext2_inode).
>>
>> Aha!  So here's another question:  Is it fair to ask Reiser4 to make its
>> plugins generic, or should we be asking ext2/3 first?
>>
> 
> Doesn't iptables have plugins? Maybe we should make them generic so 
> other packet filters can use them ;)

Hey, yeah!  I mean, not everyone wants to run the ipchains emulation on 
top of iptables!  Some people really want to run ipchains with iptables 
plugins!

</sarcasm>

It is REALLY time for this discussion to get technical again, and to go 
way, way over my head.  And it's time for me to go build my MythTV box, 
and see if I can shake out some Reiser4 bugs.
