Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751952AbWFWTTP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751952AbWFWTTP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 15:19:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751953AbWFWTTP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 15:19:15 -0400
Received: from wr-out-0506.google.com ([64.233.184.236]:36154 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751952AbWFWTTO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 15:19:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Ecg4G4SJbakLrTu3ucy/CEPZeBCh++vP04sUVREzJ3KkOOWSH5Ow4fdiHRX9pyZ4H2ni38zn2RLo5Q/bu5OgU7279440satHG3RvZibK9+MEsHkByv+EhkOg1LbTWQ4ZPQ7/ge6XnGLPmv4dTPtLAmTUIS5LGnTFKEsypj949cQ=
Message-ID: <38b19aa60606231219n57b18a81i51b3b3a55a94406e@mail.gmail.com>
Date: Fri, 23 Jun 2006 12:19:13 -0700
From: "Hareesh Nagarajan" <hnagar2@gmail.com>
To: "Darren Reed" <darrenr@reed.wattle.id.au>
Subject: Re: 2.6.11: spinlock problem
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200606231651.k5NGpbYr008153@firewall.reed.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200606231651.k5NGpbYr008153@firewall.reed.wattle.id.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/23/06, Darren Reed <darrenr@reed.wattle.id.au> wrote:
> Is this
> (a) linux allowing the IRQ too early
> (b) vmware not doing something right
> (c) enivitable
> (d) somehow my fault
> (e) something else?

Turn on spin lock debugging.

-- 
./hareesh
