Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313830AbSDIJm3>; Tue, 9 Apr 2002 05:42:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313831AbSDIJm2>; Tue, 9 Apr 2002 05:42:28 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:49938 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S313830AbSDIJm1>; Tue, 9 Apr 2002 05:42:27 -0400
Message-Id: <200204090939.g399dlX02029@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Nick Martens <nickm@kabelfoon.nl>
Subject: Re: 2.4.18 Boot problem
Date: Tue, 9 Apr 2002 12:43:00 -0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org, rowan.ingvar.wilson@0800dial.com
In-Reply-To: <3CB1B505.2010505@kabelfoon.nl> <3CB1FE78.6050606@kabelfoon.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8 April 2002 18:32, Nick Martens wrote:
> I don't expect it to be a memory problem my system is really stable and
> the weirdest about the problem is that it only happens the first time I
> boot up after my pc has been turned off for a while and there are no
> problems when i boot 2.5.1 it only crashes on shutdowns on that kernel.
> I have tried updating all kind of things, but noting seems to work

Is your "for a while" >= ten seconds? Nothing in CPU/RAM can survive
that long.

I'd say this is a hardware problem then. Something in your box does not like 
to be cold.
--
vda
