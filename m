Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313181AbSIHSnU>; Sun, 8 Sep 2002 14:43:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313190AbSIHSnU>; Sun, 8 Sep 2002 14:43:20 -0400
Received: from 62-190-201-125.pdu.pipex.net ([62.190.201.125]:34823 "EHLO
	darkstar.example.net") by vger.kernel.org with ESMTP
	id <S313181AbSIHSnU>; Sun, 8 Sep 2002 14:43:20 -0400
From: jbradford@dial.pipex.com
Message-Id: <200209081854.g88Isuxk003676@darkstar.example.net>
Subject: Re: clean before or after dep?
To: sam@ravnborg.org (Sam Ravnborg)
Date: Sun, 8 Sep 2002 19:54:56 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020908205011.A1671@mars.ravnborg.org> from "Sam Ravnborg" at Sep 08, 2002 08:50:11 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Lets go through the targets in question, and their purpose:
> mrproper:
> mrproper removes all files generated during the build process. This
> includes the final kernel, the current configuration, firmware for
> drivers, host-progs used during compilation, buildversion, 
> the include/asm link and a few more files.

This used to be called distclean, right?

John.
