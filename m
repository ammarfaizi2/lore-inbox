Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964913AbWBGIeH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964913AbWBGIeH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 03:34:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964980AbWBGIeH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 03:34:07 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:14300 "HELO
	ilport.com.ua") by vger.kernel.org with SMTP id S964913AbWBGIeF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 03:34:05 -0500
From: Denis Vlasenko <vda@ilport.com.ua>
To: Grant Ian Hatamosa <grant_hatamosa@yahoo.com>
Subject: Re: Fedora Core 2 with Linux 2.6.14.7 hangs when webcam attached thru HS USB hub
Date: Tue, 7 Feb 2006 10:32:36 +0200
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org
References: <20060207070611.63765.qmail@web37810.mail.mud.yahoo.com>
In-Reply-To: <20060207070611.63765.qmail@web37810.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602071032.36701.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 07 February 2006 09:06, Grant Ian Hatamosa wrote:
> Hi!
> 
> I wanted to know if anybody can show me how to resolve
> an issue with my system.
> 
> I am having some problem if I attach an Intel webcam
> (model CS330) through a high speed hub (forgot the
> name and model of the hub). Once I got the webcam
> enumerated and run an application, like gnomemeeting,
> the system just hangs. I looked at /var/log/messages/
> but it does not get me much clues even after I have
> turned USB verbose messaging, as well as, spca5xx
> messaging already ON. It kinda stopped in a middle of
> a reg_write in the spca5xx system.

Do not describe /var/log/messages, just post a tail of it.

http://www.catb.org/~esr/faqs/smart-questions.html
--
vda
