Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262911AbTDNJSh (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 05:18:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262914AbTDNJSh (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 05:18:37 -0400
Received: from 169.imtp.Ilyichevsk.Odessa.UA ([195.66.192.169]:7439 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id S262911AbTDNJSh (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 05:18:37 -0400
Message-Id: <200304140922.h3E9Lvu02312@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Frank Van Damme <frank.vandamme@student.kuleuven.ac.be>,
       linux-kernel@vger.kernel.org
Subject: Re: stabilty problems using opengl on kt400 based system
Date: Mon, 14 Apr 2003 12:16:59 +0300
X-Mailer: KMail [version 1.3.2]
References: <200304121410.58522.frank.vandamme@student.kuleuven.ac.be>
In-Reply-To: <200304121410.58522.frank.vandamme@student.kuleuven.ac.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12 April 2003 15:10, Frank Van Damme wrote:
> compiling. However, if Istart running OpenGL applications (games)
> (quake,tuxracer or whatever) themachine will freeze in anything from
> 2 minutes to an hour. The last frame remains on the screen, but I can
> still login over ssh and reboot. The drivers of this card are only

Can you login over ssh and collect useful info?
Top, ps, various /proc/* files?
--
vda
