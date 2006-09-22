Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932612AbWIVPqU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932612AbWIVPqU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 11:46:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932523AbWIVPqU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 11:46:20 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:44864 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932613AbWIVPqS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 11:46:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=C66egnbxNcV70wY7A0cNf3y+NDm4XvSdMI8jkl81OlTaObYRNPa0ChTg33EtxniEw45e9dVplrwFnCPSTXnDVxVSLuBz6MN6UjPKGGTYcZlm0uTs55NHiC6FWyOXdFEQq4hjYJ4XQ9yL48wPbOm6ViSWiyT+B2kxvz/y0sC93Yk=
Message-ID: <45140539.5080001@gmail.com>
Date: Sat, 23 Sep 2006 00:46:01 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060915)
MIME-Version: 1.0
To: dipankar@in.ibm.com
CC: viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] file: kill unnecessary timer in fdtable_defer
References: <20060820131542.GN6371@htj.dyndns.org> <20060821043257.GD5433@in.ibm.com> <20060821051816.GP6371@htj.dyndns.org> <20060821075818.GG5433@in.ibm.com>
In-Reply-To: <20060821075818.GG5433@in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Dipankar.

It has been a month and this thread hasn't gotten anywhere.  If there is 
no further objection, I'll try to push it through -mm for testing.

Thanks.

-- 
tejun
