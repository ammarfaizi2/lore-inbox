Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261730AbTILPgN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 11:36:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261744AbTILPgM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 11:36:12 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:21257 "HELO
	127.0.0.1") by vger.kernel.org with SMTP id S261730AbTILPgL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 11:36:11 -0400
Content-Type: text/plain;
  charset="utf-8"
From: insecure <insecure@mail.od.ua>
Reply-To: insecure@mail.od.ua
To: "Breno" <brenosp@brasilsec.com.br>, "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Subject: Re: Size of Tasks during ddos
Date: Fri, 12 Sep 2003 18:36:01 +0300
X-Mailer: KMail [version 1.4]
Cc: "Kernel List" <linux-kernel@vger.kernel.org>
References: <001b01c39047$d65cf580$f8e4a7c8@bsb.virtua.com.br> <1063312815.3886.0.camel@dhcp23.swansea.linux.org.uk> <008901c39044$597dd320$f8e4a7c8@bsb.virtua.com.br>
In-Reply-To: <008901c39044$597dd320$f8e4a7c8@bsb.virtua.com.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200309121836.01407.insecure@mail.od.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 12 October 2003 01:09, Breno wrote:
> Suppose that one task during a ddos receive much data , so it can try to
> alloc much memory to control this data, or to control the list of sockets
> in listen state.

Hi Breno,

Can you please fix your clock? Thanks
--
vda
