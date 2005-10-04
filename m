Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932302AbVJDCuD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932302AbVJDCuD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 22:50:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932306AbVJDCuB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 22:50:01 -0400
Received: from sv1.valinux.co.jp ([210.128.90.2]:23716 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S932302AbVJDCuB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 22:50:01 -0400
Date: Tue, 4 Oct 2005 11:49:59 +0900
From: KUROSAWA Takahiro <kurosawa@valinux.co.jp>
To: Paul Jackson <pj@sgi.com>
Cc: taka@valinux.co.jp, magnus.damm@gmail.com, dino@in.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] CPUMETER (Re: [PATCH 0/5] SUBCPUSETS: a resource
 control functionality using CPUSETS)
In-Reply-To: <20051001212026.1d39222a.pj@sgi.com>
References: <20050908225539.0bc1acf6.pj@sgi.com>
	<20050909.203849.33293224.taka@valinux.co.jp>
	<20050909063131.64dc8155.pj@sgi.com>
	<20050910.161145.74742186.taka@valinux.co.jp>
	<20050910015209.4f581b8a.pj@sgi.com>
	<20050926093432.626D07003D@sv1.valinux.co.jp>
	<20051001212026.1d39222a.pj@sgi.com>
X-Mailer: Sylpheed version 2.1.3 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20051004025000.07DC470040@sv1.valinux.co.jp>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 1 Oct 2005 21:20:26 -0700
Jackson-san wrote:

> I spent a little more reading the cpuset side of your cpumeter patches.
> 
> I am hopeful that some substantial restructuring of the code would
> integrate it better with the existing cpuset structure, reducing the
> size of new code substantially.

Thanks for the suggestion.
I'll update my patch and send it when I finish updating.
