Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262700AbSI1E02>; Sat, 28 Sep 2002 00:26:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262701AbSI1E02>; Sat, 28 Sep 2002 00:26:28 -0400
Received: from ns.commfireservices.com ([216.6.9.162]:44558 "HELO
	hemi.commfireservices.com") by vger.kernel.org with SMTP
	id <S262700AbSI1E01>; Sat, 28 Sep 2002 00:26:27 -0400
Date: Sat, 28 Sep 2002 00:30:42 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Dipankar Sarma <dipankar@in.ibm.com>
Cc: William Lee Irwin III <wli@holomorphy.com>, Andrew Morton <akpm@digeo.com>,
       lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: 2.5.38-mm3
In-Reply-To: <20020927092020.GS3530@holomorphy.com>
Message-ID: <Pine.LNX.4.44.0209280026100.32347-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Sep 2002, William Lee Irwin III wrote:

> On Fri, Sep 27, 2002 at 01:57:43PM +0530, Dipankar Sarma wrote:
> > What application were you all running ?
> > Thanks
> 
> Basically, the workload on my "desktop" system consists of numerous ssh
> sessions in and out of the machine, half a dozen IRC clients, xmms,
> Mozilla, and X overhead.

That box is my development/main box, i run a lot of xterms, xmms, network 
applications (ssh, browsers, irc etc...). Heavy simulator usage (i believe 
thats where the poll stuff comes from, due to its virtual ethernet 
interface) all done in X and the box is also local NFS server for the 
various testboxes i have (heavy I/O, disk load) as well as kernel 
compiles.

	Zwane

--
function.linuxpower.ca

