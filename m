Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293314AbSCUIMg>; Thu, 21 Mar 2002 03:12:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293541AbSCUIM0>; Thu, 21 Mar 2002 03:12:26 -0500
Received: from ns.suse.de ([213.95.15.193]:10000 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S293314AbSCUIMO>;
	Thu, 21 Mar 2002 03:12:14 -0500
To: Rolf Eike Beer <eike@bilbo.math.uni-mannheim.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.7 Documentation/00-INDEX
In-Reply-To: <200203210835.51213@bilbo.math.uni-mannheim.de>
From: Andreas Jaeger <aj@suse.de>
Date: Thu, 21 Mar 2002 09:12:12 +0100
Message-ID: <hog02upcf7.fsf@gee.suse.de>
User-Agent: Gnus/5.090006 (Oort Gnus v0.06) XEmacs/21.4 (Artificial
 Intelligence, i386-suse-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rolf Eike Beer <eike@bilbo.math.uni-mannheim.de> writes:

> This patch updates Documentation/00-INDEX. It removes some lines describing 
> files that have been removed/moved to subdirectories. Also it adds some lines 
> on new files/directories.
>
> Eike
>
> --- linux-2.5.7/Documentation/00-INDEX.orig	Thu Mar 21 08:04:54 2002
> +++ linux-2.5.7/Documentation/00-INDEX	Thu Mar 21 08:29:08 2002

[..]
> +x86_64/
> +	- directory with info on Linux support for 64 bit x86 machines.

x86-64 is it's own archtitecture, please don't call it 64 bit x86
machines.  Just write:
directory with info on Linux support for AMD x86-64 (Hammer) machines.

Andreas
-- 
 Andreas Jaeger
  SuSE Labs aj@suse.de
   private aj@arthur.inka.de
    http://www.suse.de/~aj
