Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317917AbSGRC2w>; Wed, 17 Jul 2002 22:28:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317959AbSGRC2w>; Wed, 17 Jul 2002 22:28:52 -0400
Received: from w089.z209220022.nyc-ny.dsl.cnc.net ([209.220.22.89]:16517 "HELO
	yucs.org") by vger.kernel.org with SMTP id <S317917AbSGRC2w>;
	Wed, 17 Jul 2002 22:28:52 -0400
Subject: Re: more thoughts on a new jail() system call
From: Shaya Potter <spotter@cs.columbia.edu>
To: linux-kernel@vger.kernel.org
In-Reply-To: <1026959170.14737.102.camel@zaphod>
References: <1026959170.14737.102.camel@zaphod>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.7 
Date: 17 Jul 2002 22:30:58 -0400
Message-Id: <1026959460.14737.109.camel@zaphod>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

woops, change this (from an earlier draft, where i was using different
names)

sys_wait4) J - Can only wait on a process in its jail

possibly some other mistakes, feel free to rip it apart of course :)

