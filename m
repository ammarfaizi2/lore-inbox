Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263204AbUGFGiw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263204AbUGFGiw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 02:38:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263413AbUGFGiw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 02:38:52 -0400
Received: from mailout.zma.compaq.com ([161.114.64.104]:9479 "EHLO
	zmamail04.zma.compaq.com") by vger.kernel.org with ESMTP
	id S263204AbUGFGiv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 02:38:51 -0400
Message-ID: <40EA490C.40703@hp.com>
Date: Tue, 06 Jul 2004 12:09:08 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@hp.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040624 Debian/1.7-2
X-Accept-Language: en
MIME-Version: 1.0
Newsgroups: fa.linux.kernel
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: Daniel Phillips <phillips@redhat.com>,
       Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Minneapolis Cluster Summit, July 29-30
References: <fa.io9lp90.1c02foo@ifi.uio.no> <fa.go9f063.1i72joh@ifi.uio.no>
In-Reply-To: <fa.go9f063.1i72joh@ifi.uio.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Friesen wrote:
> Daniel Phillips wrote:
> 
>> Don't you think we ought to take a look at how OCFS and GFS might share
>> some of the same infrastructure, for example, the DLM and cluster
>> membership services?
> 
> 
> For cluster membership, you might consider looking at the OpenAIS CLM 
> portion. It would be nice if this type of thing was unified across more 
> than just filesystems.
> 
> 

How about  looking Cluster Infrastructure ( http://ci-linux.sf.net ) and 
OpenSSI ( http://www.openssi.org ) for cluster membership service.

-aneesh
