Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262089AbTAaUEQ>; Fri, 31 Jan 2003 15:04:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262190AbTAaUEQ>; Fri, 31 Jan 2003 15:04:16 -0500
Received: from adsl-67-120-62-187.dsl.lsan03.pacbell.net ([67.120.62.187]:49676
	"EHLO exchange.macrolink.com") by vger.kernel.org with ESMTP
	id <S262089AbTAaUEQ>; Fri, 31 Jan 2003 15:04:16 -0500
Message-ID: <11E89240C407D311958800A0C9ACF7D1A33D78@EXCHANGE>
From: Ed Vance <EdV@macrolink.com>
To: "'Jeff Garzik'" <jgarzik@pobox.com>,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org,
       Konrad Eisele <eiselekd@web.de>
Subject: RE: Perl in the toolchain
Date: Fri, 31 Jan 2003 12:13:40 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 31, 2003 at 11:49 AM, Jeff Garzik wrote:
> 
> On Fri, Jan 31, 2003 at 01:41:26PM -0600, Kai Germaschewski wrote:
> > Generally, we've been trying to not make perl a prequisite 
> > for the kernel build, and I'd like to keep it that way. 
> > Except for some arch specific 
> 
> That's pretty much out the window when klibc gets merged, so perl will
> indeed be a build requirement for all platforms...
> 

The solution is obvious:
Write a perl interpreter in Python!
of course, to avoid merely moving the problem, Python then would be
implemented in a bash script ... 
