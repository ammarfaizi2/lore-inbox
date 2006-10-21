Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161052AbWJUU7s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161052AbWJUU7s (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 16:59:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161054AbWJUU7s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 16:59:48 -0400
Received: from smtp-out.google.com ([216.239.45.12]:29400 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1161052AbWJUU7r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 16:59:47 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:to:subject:cc:in-reply-to:
	mime-version:content-type:content-transfer-encoding:
	content-disposition:references;
	b=fwIaf1NDepQxGBvQJ6dkBYTsJ1Qpdc3ABu7MdMnp7TJKf1Js7Ly5QDEee4kj+TPQs
	Gj8Z8Unqc/6n3S2WBHFSw==
Message-ID: <6599ad830610211359q76d4f7eav1367109bdb81c786@mail.gmail.com>
Date: Sat, 21 Oct 2006 13:59:40 -0700
From: "Paul Menage" <menage@google.com>
To: "Paul Jackson" <pj@sgi.com>
Subject: Re: [RFC] cpuset: remove sched domain hooks from cpusets
Cc: mbligh@google.com, nickpiggin@yahoo.com.au, akpm@osdl.org,
       Simon.Derr@bull.net, linux-kernel@vger.kernel.org, dino@in.ibm.com,
       rohitseth@google.com, holt@sgi.com, dipankar@in.ibm.com,
       suresh.b.siddha@intel.com
In-Reply-To: <20061021135516.5deaa3e4.pj@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061019092358.17547.51425.sendpatchset@sam.engr.sgi.com>
	 <4537527B.5050401@yahoo.com.au> <20061019120358.6d302ae9.pj@sgi.com>
	 <4537D056.9080108@yahoo.com.au> <4537D6E8.8020501@google.com>
	 <6599ad830610211123i35d2e132y8ef1e0f612b94877@mail.gmail.com>
	 <20061021135516.5deaa3e4.pj@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/21/06, Paul Jackson <pj@sgi.com> wrote:
>
> How many CPUs are you juggling?

Not many by your standards - less than eight in general.

Paul
