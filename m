Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277024AbRJQS0C>; Wed, 17 Oct 2001 14:26:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277027AbRJQSZw>; Wed, 17 Oct 2001 14:25:52 -0400
Received: from 216-21-153-1.ip.van.radiant.net ([216.21.153.1]:42765 "HELO
	innerfire.net") by vger.kernel.org with SMTP id <S277024AbRJQSZf>;
	Wed, 17 Oct 2001 14:25:35 -0400
Date: Wed, 17 Oct 2001 11:28:03 -0700 (PDT)
From: Gerhard Mack <gmack@innerfire.net>
To: Christoph Lameter <christoph@lameter.com>
cc: Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
Subject: Re: GPLONLY kernel symbols??? 
In-Reply-To: <Pine.LNX.4.33.0110162314320.7330-100000@devel.office>
Message-ID: <Pine.LNX.4.10.10110171126480.5821-100000@innerfire.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Oct 2001, Christoph Lameter wrote:

> On Wed, 17 Oct 2001, Keith Owens wrote:
> 
> > On Tue, 16 Oct 2001 21:59:03 -0700 (PDT),
> > Christoph Lameter <christoph@lameter.com> wrote:
> > >The loop driver is not GPL compatible???
> >
> > In 2.4.11 loop.c has no MODULE_LICENCE.  It will take a while for all
> > modules to be correctly flagged.
> 
> Then do not output such a message. This is not M$ windows.
> 
And how do you expect them to find all of the modules that don't have
MODULE_LICENCE if they can't see an indicator in the boot messages?

	Gerhard

--
Gerhard Mack

gmack@innerfire.net

<>< As a computer I find your faith in technology amusing.

