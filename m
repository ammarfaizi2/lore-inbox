Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261297AbSJ1PHa>; Mon, 28 Oct 2002 10:07:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261298AbSJ1PHa>; Mon, 28 Oct 2002 10:07:30 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:41697 "EHLO
	flossy.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S261297AbSJ1PHK>; Mon, 28 Oct 2002 10:07:10 -0500
Date: Mon, 28 Oct 2002 10:15:18 -0500
From: Doug Ledford <dledford@redhat.com>
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.44-ac3
Message-ID: <20021028151517.GA18875@redhat.com>
Mail-Followup-To: Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org
References: <200210251019.g9PAJ8V14406@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200210251019.g9PAJ8V14406@devserv.devel.redhat.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2002 at 06:19:08AM -0400, Alan Cox wrote:
>    Doug's scsi changes broke mptfusion. I've not looked into that yet
>    also u14f/u34f.

Fixed in linux-scsi.bkbits.net/scsi-misc-2.5  Well, the mptfusion is, not 
sure about u14f/u34f.  I think I have that turned off in my builds because 
it was still broken in regards to the PCI DMA mapping API last I knew.

-- 
  Doug Ledford <dledford@redhat.com>     919-754-3700 x44233
         Red Hat, Inc. 
         1801 Varsity Dr.
         Raleigh, NC 27606
  
