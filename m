Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285413AbRLGEhG>; Thu, 6 Dec 2001 23:37:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285411AbRLGEgx>; Thu, 6 Dec 2001 23:36:53 -0500
Received: from dsl-213-023-043-086.arcor-ip.net ([213.23.43.86]:27912 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S285408AbRLGEgc>;
	Thu, 6 Dec 2001 23:36:32 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Hans Reiser <reiser@namesys.com>
Subject: Re: [reiserfs-dev] Re: Ext2 directory index: ALS paper and benchmarks
Date: Fri, 7 Dec 2001 05:39:13 +0100
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com,
        ramon@thebsh.namesys.com, yura@namesys.com
In-Reply-To: <E16BjYc-0000hS-00@starship.berlin> <E16C2EN-0000pz-00@starship.berlin> <3C1009B8.8080300@namesys.com>
In-Reply-To: <3C1009B8.8080300@namesys.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16CCn9-0000sC-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On December 7, 2001 01:13 am, Hans Reiser wrote:
> Daniel Phillips wrote:
> >Fully understanding your code is going to take some time.  This would 
> >go faster if I could find the papers mentioned in the comments, can you point 
> >me at those?
>
> Which papers in which comments?

  http://innominate.org/~graichen/projects/lxr/source/include/linux/reiserfs_fs.h?v=v2.4#L1393 

  1393 create a new node.  We implement S1 balancing for the leaf nodes
  1394 and S0 balancing for the internal nodes (S1 and S0 are defined in
  1395 our papers.)*/

--
Daniel
