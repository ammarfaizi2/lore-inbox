Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289352AbSA3QFG>; Wed, 30 Jan 2002 11:05:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289340AbSA3QEx>; Wed, 30 Jan 2002 11:04:53 -0500
Received: from nat-pool-meridian.redhat.com ([12.107.208.200]:58329 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S289341AbSA3QDm>; Wed, 30 Jan 2002 11:03:42 -0500
Date: Wed, 30 Jan 2002 11:03:35 -0500
From: Jakub Jelinek <jakub@redhat.com>
To: Suparna Bhattacharya <suparna@in.ibm.com>
Cc: linux-aio@kvack.org, linux-kernel@vger.kernel.org,
        lse-tech@lists.sourceforge.net
Subject: Re: Fw: Writeup on AIO design (uploaded) - corrected url
Message-ID: <20020130110335.O10157@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
In-Reply-To: <20020130205115.B1864@in.ibm.com> <20020130104627.N10157@devserv.devel.redhat.com> <20020130213047.A2143@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020130213047.A2143@in.ibm.com>; from suparna@in.ibm.com on Wed, Jan 30, 2002 at 09:30:47PM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2002 at 09:30:47PM +0530, Suparna Bhattacharya wrote:
> Thanks for the clarification.
> What is the aio thread limit like ? 

Default is max 20 threads, but one can change this in aio_init().

	Jakub
