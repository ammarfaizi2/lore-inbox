Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318708AbSHAL6d>; Thu, 1 Aug 2002 07:58:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318709AbSHAL6d>; Thu, 1 Aug 2002 07:58:33 -0400
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:57079 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S318708AbSHAL6c>; Thu, 1 Aug 2002 07:58:32 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20020731131620.M15238@lustre.cfs> 
References: <20020731131620.M15238@lustre.cfs> 
To: "Peter J. Braam" <braam@clusterfs.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: BIG files & file systems 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 01 Aug 2002 13:01:56 +0100
Message-ID: <6811.1028203316@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


braam@clusterfs.com said:
> (you don't want to know who, besides I've no idea how many bits go in
> a trillion, but it's more than 32). 

It all gets a little confusing after 'million'. Either you mean a US 
'trillion', which is a European 'billion'; 10^12. Or you mean a European 
'trillion', which is a US 'quintillion'; 10^18.

In general, it's best to stick to the numeric form if it's greater than
10^6. With the possible exception of using 'milliard' for 10^9, which may 
cause the recipient to have to look up the word, but won't cause it to be 
misinterpreted as 10^12 by non-usians.

http://216.239.33.100/search?q=cache:rwJFJLB7ZnoC:www.reportercentral.com/reference/vocabulary/numbernames.html

--
dwmw2


