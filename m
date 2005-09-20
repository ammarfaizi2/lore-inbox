Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964929AbVITIhv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964929AbVITIhv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 04:37:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964928AbVITIhv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 04:37:51 -0400
Received: from zproxy.gmail.com ([64.233.162.195]:136 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964929AbVITIhv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 04:37:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pvvbcpiYcbsoeijhyamUJIreK8AHYx+rD6R9sWhQ48myScYNdJe+noBJ9qYWVteEQRgSlnI/M0epr4jeufNZo1kniaOP5JiY3VQs9ha7KVdF+gv55bqBg/NuKOdfyt23BNtY/v+mIEwujeJtPy4rxSQyuocaZzva0lWPICblQyQ=
Message-ID: <1e62d137050920013752bf31d7@mail.gmail.com>
Date: Tue, 20 Sep 2005 13:37:48 +0500
From: Fawad Lateef <fawadlateef@gmail.com>
Reply-To: fawadlateef@gmail.com
To: Denis Vlasenko <vda@ilport.com.ua>
Subject: Re: regarding kernel compilation
Cc: Gireesh Kumar <gireesh.kumar@einfochips.com>, linux-kernel@vger.kernel.org
In-Reply-To: <200509201112.28091.vda@ilport.com.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <32854.192.168.9.246.1127197320.squirrel@192.168.9.246>
	 <1e62d13705092000112a49cb6c@mail.gmail.com>
	 <200509201112.28091.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/05, Denis Vlasenko <vda@ilport.com.ua> wrote:
> On Tuesday 20 September 2005 10:11, Fawad Lateef wrote:
> > I don't think you will be able to compile 2.4 kernel on to the 2.6
> > kernel based distro .... as in 2.6 based distro, mod-utils and other
> 
> 2.6 modutils (module-init-tools to be exact) fall back to <toolname>.old
> (by just exec'ing it) if those exist.
> 

you are right, but if they exists .... but what IIRC I havn't found
them on FC4/RH EL4 distributions .....

> > packages are updated and will only support 2.6 based kernel .... So
> 
> Not true. I compiled 2.4 kernels on 2.6 machine without any problems.
> 
On which distribution 2.6 based you compiled and succesfully run 2.4
kernel ??? b/c its not working on FC3/FC4/AS4 .........

-- 
Fawad Lateef
