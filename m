Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754313AbWKHFh3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754313AbWKHFh3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 00:37:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754314AbWKHFh3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 00:37:29 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:3989 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1754312AbWKHFh2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 00:37:28 -0500
Date: Tue, 7 Nov 2006 21:36:27 -0800
From: Paul Jackson <pj@sgi.com>
To: vatsa@in.ibm.com
Cc: dev@openvz.org, sekharan@us.ibm.com, ckrm-tech@lists.sourceforge.net,
       balbir@in.ibm.com, haveblue@us.ibm.com, linux-kernel@vger.kernel.org,
       matthltc@us.ibm.com, dipankar@in.ibm.com, rohitseth@google.com,
       menage@google.com
Subject: Re: [ckrm-tech] [RFC] Resource Management - Infrastructure choices
Message-Id: <20061107213627.dc6ba1ce.pj@sgi.com>
In-Reply-To: <20061108051257.GB2964@in.ibm.com>
References: <20061031115342.GB9588@in.ibm.com>
	<6599ad830610310846m5d718d22p5e1b569d4ef4e63@mail.gmail.com>
	<20061101172540.GA8904@in.ibm.com>
	<6599ad830611011537i2de812fck99822d3dd1314992@mail.gmail.com>
	<20061106124948.GA3027@in.ibm.com>
	<6599ad830611061223m77c0ef1ei72bd7729d9284ec6@mail.gmail.com>
	<20061107104118.f02a1114.pj@sgi.com>
	<6599ad830611071107u4226ec17h5facc7ee2ad53174@mail.gmail.com>
	<6599ad830611071421s7792bbb1qd9c7b1fc840dfa50@mail.gmail.com>
	<20061107191518.c094ce1a.pj@sgi.com>
	<20061108051257.GB2964@in.ibm.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Srivatsa wrote:
> As was discussed in a previous thread, having a 'threads' file also will
> be good.
> 
> 	http://lkml.org/lkml/2006/11/1/386
> 
> Writing to 'tasks' file will move that single thread to the new
> container. Writing to 'threads' file will move all the threads of the
> process into the new container.

Yup - agreed.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
