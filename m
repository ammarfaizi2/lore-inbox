Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312534AbSCUW0c>; Thu, 21 Mar 2002 17:26:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312539AbSCUW0X>; Thu, 21 Mar 2002 17:26:23 -0500
Received: from aaf16.warszawa.sdi.tpnet.pl ([217.97.85.16]:33291 "EHLO
	aaf16.warszawa.sdi.tpnet.pl") by vger.kernel.org with ESMTP
	id <S312534AbSCUW0K>; Thu, 21 Mar 2002 17:26:10 -0500
Date: Thu, 21 Mar 2002 23:24:01 +0100
From: Dominik Mierzejewski <dominik@rangers.eu.org>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19-pre4: Compiler crash in i386/kernel/mpparse.c
Message-ID: <20020321222401.GA32484@rathann.rangers.eu.org>
In-Reply-To: <200203212233.07125.lk_ml@libero.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Linux-Registered-User: 134951
X-Homepage: http://home.elka.pw.edu.pl/~dmierzej/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, 21 March 2002, petali grigi wrote:
> 
> gcc crashes compiling arch/i386/kernel/mpparse.c  line 41
> 
> gcc version 3.0.2 20010905 (Red Hat Linux 7.1 3.0.1-3) 
> (the one shipped with RH 7.2)

Try gcc3-3.0.4 from updates.

-- 
"The Universe doesn't give you any points for doing things that are easy."
        -- Sheridan to Garibaldi in Babylon 5:"The Geometry of Shadows"
Dominik 'Rathann' Mierzejewski <rathann(at)rangers.eu.org>
