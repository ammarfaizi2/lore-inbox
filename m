Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292700AbSCOOyw>; Fri, 15 Mar 2002 09:54:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292702AbSCOOym>; Fri, 15 Mar 2002 09:54:42 -0500
Received: from mail-01.med.umich.edu ([141.214.93.149]:30889 "EHLO
	mail-01.med.umich.edu") by vger.kernel.org with ESMTP
	id <S292700AbSCOOyZ> convert rfc822-to-8bit; Fri, 15 Mar 2002 09:54:25 -0500
Message-Id: <sc91c4ce.020@mail-01.med.umich.edu>
X-Mailer: Novell GroupWise Internet Agent 6.0.1
Date: Fri, 15 Mar 2002 09:54:05 -0500
From: "Nicholas Berry" <nikberry@med.umich.edu>
To: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.4 and 2.5: remove Alt-Sysrq-L
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I distinctly recall it working perfectly OK in around 2.1.50. I had boxen 
> where /sbin/init was a shell script which would bring up the interfaces,
> enable routing, and exit.

That's a different thing, I think. 

That is, 'init exiting' versus 'all the code to prevent init being killed is bypassed and init is killed'

