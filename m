Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310186AbSCGLs7>; Thu, 7 Mar 2002 06:48:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310204AbSCGLsr>; Thu, 7 Mar 2002 06:48:47 -0500
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:8687 "HELO
	executor.cambridge.redhat.com") by vger.kernel.org with SMTP
	id <S310186AbSCGLsb>; Thu, 7 Mar 2002 06:48:31 -0500
Message-ID: <3C87538D.9962723D@redhat.com>
Date: Thu, 07 Mar 2002 11:48:29 +0000
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
Organization: Red Hat, Inc
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.9-26beta.16smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jean-Eric Cuendet <jean-eric.cuendet@linkvest.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Rework of /proc/stat
In-Reply-To: <E16ik6y-0008Qf-00@the-village.bc.nu> <3C874AE8.9060208@linkvest.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean-Eric Cuendet wrote:
> 
> Alan Cox wrote:
> 
> >
> >Any reason for preferring this over the sard patches in -ac ?
> >
> What does the sard patches?
> What I need is to be able to get IO stats to pass them (through a home
> made script) to SNMP which have no IO stats available.
> Is it possible to get SARD values through /proc ? Or at least in a
> simple shell script?

yes.

man iostat
