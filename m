Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268344AbTBNJaB>; Fri, 14 Feb 2003 04:30:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268341AbTBNJ33>; Fri, 14 Feb 2003 04:29:29 -0500
Received: from hugin.diku.dk ([130.225.96.144]:776 "HELO hugin.diku.dk")
	by vger.kernel.org with SMTP id <S268254AbTBNJ2Z>;
	Fri, 14 Feb 2003 04:28:25 -0500
Date: Fri, 14 Feb 2003 10:38:17 +0100 (MET)
From: Peter Finderup Lund <firefly@diku.dk>
To: "Thomas J. Merritt" <tjm@codegen.com>
cc: Peter Tattam <peter@jazz-1.trumpet.com.au>, <linux-kernel@vger.kernel.org>,
       <discuss@x86-64.org>
Subject: Re: [discuss] Re: [Bug 350] New: i386 context switch very slow
 compared to 2.4 due to wrmsr (performance) 
In-Reply-To: <200302140407.h1E477oP041875@tenor.codegen.com>
Message-ID: <Pine.LNX.4.44L0.0302141037180.4760-100000@ask.diku.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Feb 2003, Thomas J. Merritt wrote:

> The only way to get from long-mode back to legacy-mode is to reset the
> processor.  It can be done in software but you will likely lose interrupts.

Smartdrv.sys and triple-faults come back, all is forgiven!  ;)

-Peter

