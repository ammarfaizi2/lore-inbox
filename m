Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965077AbWECDRi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965077AbWECDRi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 23:17:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965079AbWECDRi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 23:17:38 -0400
Received: from relais.videotron.ca ([24.201.245.36]:56362 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S965077AbWECDRi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 23:17:38 -0400
Date: Tue, 02 May 2006 23:17:37 -0400 (EDT)
From: Nicolas Pitre <nico@cam.org>
Subject: Re: [RFC] Advanced XIP File System
In-reply-to: <625fc13d0605021756v7a8e0d7p1e9d8e4c810bc092@mail.gmail.com>
X-X-Sender: nico@localhost.localdomain
To: Josh Boyer <jwboyer@gmail.com>
Cc: Jared Hulbert <jaredeh@gmail.com>, linux-kernel@vger.kernel.org
Message-id: <Pine.LNX.4.64.0605022316550.28543@localhost.localdomain>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <6934efce0605021453l31a438c4j7c429e6973ab4546@mail.gmail.com>
 <625fc13d0605021756v7a8e0d7p1e9d8e4c810bc092@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 May 2006, Josh Boyer wrote:

> On 5/2/06, Jared Hulbert <jaredeh@gmail.com> wrote
> > 
> > Why a new filesystem?
> > - XIP of kernel is mainline, but not XIP of applications.  This
> > enables application XIP
> 
> From what I recall, XIP of the kernel off of MTD is limited to ARM.

It doesn't have to.


Nicolas
