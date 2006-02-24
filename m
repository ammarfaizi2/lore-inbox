Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932076AbWBXIGe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932076AbWBXIGe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 03:06:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932086AbWBXIGd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 03:06:33 -0500
Received: from ylpvm43-ext.prodigy.net ([207.115.57.74]:36766 "EHLO
	ylpvm43.prodigy.net") by vger.kernel.org with ESMTP id S932076AbWBXIGd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 03:06:33 -0500
X-ORBL: [68.252.239.198]
Message-ID: <43FEBE83.6070700@gmail.com>
Date: Fri, 24 Feb 2006 02:06:27 -0600
From: Hareesh Nagarajan <hnagar2@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Wei Hu <glegoo@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Looking for a file monitor
References: <5be025980602232351k3f6182bbqed5ea54079193953@mail.gmail.com>
In-Reply-To: <5be025980602232351k3f6182bbqed5ea54079193953@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wei Hu wrote:
> I looked into dnotify but it was not what I'm looking for.  I want a
> monitor program that can intercept all file access of any process that
> satisfy a given filter.  Is there a program?  I searched on Google but
> had no luck.

dnotify has been succeeded by inotify. check the link below:
	http://www.kernel.org/pub/linux/kernel/people/rml/inotify/README

./hareesh
