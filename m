Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751676AbWKGTLy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751676AbWKGTLy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 14:11:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751887AbWKGTLy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 14:11:54 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:15570 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751676AbWKGTLx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 14:11:53 -0500
Date: Tue, 7 Nov 2006 11:11:31 -0800
From: Paul Jackson <pj@sgi.com>
To: "Paul Menage" <menage@google.com>
Cc: vatsa@in.ibm.com, dev@openvz.org, sekharan@us.ibm.com,
       ckrm-tech@lists.sourceforge.net, balbir@in.ibm.com, haveblue@us.ibm.com,
       linux-kernel@vger.kernel.org, matthltc@us.ibm.com, dipankar@in.ibm.com,
       rohitseth@google.com
Subject: Re: [ckrm-tech] [RFC] Resource Management - Infrastructure choices
Message-Id: <20061107111131.48a9ae49.pj@sgi.com>
In-Reply-To: <6599ad830611071107u4226ec17h5facc7ee2ad53174@mail.gmail.com>
References: <20061030031531.8c671815.pj@sgi.com>
	<20061030123652.d1574176.pj@sgi.com>
	<6599ad830610301247k179b32f5xa5950d8fc5a3926c@mail.gmail.com>
	<20061031115342.GB9588@in.ibm.com>
	<6599ad830610310846m5d718d22p5e1b569d4ef4e63@mail.gmail.com>
	<20061101172540.GA8904@in.ibm.com>
	<6599ad830611011537i2de812fck99822d3dd1314992@mail.gmail.com>
	<20061106124948.GA3027@in.ibm.com>
	<6599ad830611061223m77c0ef1ei72bd7729d9284ec6@mail.gmail.com>
	<20061107104118.f02a1114.pj@sgi.com>
	<6599ad830611071107u4226ec17h5facc7ee2ad53174@mail.gmail.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This will happen if you configure CONFIG_CPUSETS_LEGACY_API

So why is this CONFIG_* option separate?  When would I ever not
want it?

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
