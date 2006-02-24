Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932116AbWBXIiN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932116AbWBXIiN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 03:38:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932115AbWBXIiN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 03:38:13 -0500
Received: from zproxy.gmail.com ([64.233.162.197]:18849 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932111AbWBXIiM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 03:38:12 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pqdgSJX+UNPgpUfh4ZN6U1zv5LncH3tr4iex8Ghg/F1DS/hgFbKwWWUdEGOGtZg1WpiaD+HmlTSKPZMwgfc3mYg1Qysn2B/hU//VMuni+a7VCILCxKLCEVIL/jG3CbvH2NKs9oh3dQV+XQW+jfuabA8z2qFh/3F4dP8j01LjYvY=
Message-ID: <5be025980602240038g4206eeaai73f83cd86ef2d409@mail.gmail.com>
Date: Fri, 24 Feb 2006 03:38:11 -0500
From: "Wei Hu" <glegoo@gmail.com>
To: "Hareesh Nagarajan" <hnagar2@gmail.com>
Subject: Re: Looking for a file monitor
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <43FEBE83.6070700@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <5be025980602232351k3f6182bbqed5ea54079193953@mail.gmail.com>
	 <43FEBE83.6070700@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the information.
I understand inotify is a replacement for dnotify.
But I still don't get the advantages of it.
What kind of events can I watch?

On 2/24/06, Hareesh Nagarajan <hnagar2@gmail.com> wrote:
> Wei Hu wrote:
> > I looked into dnotify but it was not what I'm looking for.  I want a
> > monitor program that can intercept all file access of any process that
> > satisfy a given filter.  Is there a program?  I searched on Google but
> > had no luck.
>
> dnotify has been succeeded by inotify. check the link below:
>         http://www.kernel.org/pub/linux/kernel/people/rml/inotify/README
>
> ./hareesh
>
