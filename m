Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264711AbSLMOj7>; Fri, 13 Dec 2002 09:39:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264715AbSLMOj7>; Fri, 13 Dec 2002 09:39:59 -0500
Received: from orion.netbank.com.br ([200.203.199.90]:16901 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id <S264711AbSLMOj6>; Fri, 13 Dec 2002 09:39:58 -0500
Date: Fri, 13 Dec 2002 12:47:44 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Breno <breno_silva@bandnet.com.br>
Cc: Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: PROCESS IMIGRATION
Message-ID: <20021213144744.GI13367@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Breno <breno_silva@bandnet.com.br>,
	Kernel List <linux-kernel@vger.kernel.org>
References: <000701c2a208$f50e7a40$8be1a7c8@bsb.virtua.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000701c2a208$f50e7a40$8be1a7c8@bsb.virtua.com.br>
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Dec 12, 2002 at 04:04:46PM -0200, Breno escreveu:
> I saw something about one project of FreeBSD and this is about imigration of
> processes between two machines.
> The kernel Linux has something about this , or some project like that ?

Right next door (oops, city):

http://www.cos.ufrj.br/~edpin/epckpt/

   What is EPCKPT?

   EPCKPT is a checkpoint/restart utility built into the Linux kernel.
   Checkpointing is the ability to save an image of the state of a
   process (or group of processes) at a certain point during its
   lifetime. Checkpoints are important to a wide range of applications.
   The most common uses for checkpointing are:
     * Fault-tolerance
     * Applications trace/Debugging
     * Rollback/Animated playback
     * Process migration

   Our main interest right now is process migration. So, we optimized
   EPCKPT to make process' image the smaller possible, so migration costs
   would be low.

- Arnaldo
