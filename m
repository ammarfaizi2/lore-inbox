Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964879AbWHQPno@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964879AbWHQPno (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 11:43:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965044AbWHQPno
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 11:43:44 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:898 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S964879AbWHQPnn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 11:43:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=m2U/09Ni2MU5Sx9QMm4EQs6AxAfoD7ernruKlqCoZ2yESnyLcjwvL5t2KrYF9JpLTuIcFe8HJ9wjr2Ue3Ccottg6VIGGIlfIZpS0duIvRytJAq7dLqSIF/rZ9I9Pc3pL27Xmx10yy62xfZfeurrdxWFrLo1/lGEi7HA/9ypZFxI=
Date: Thu, 17 Aug 2006 19:48:15 +0400
From: Andrew Brukhov <pingved@gmail.com>
To: Nico Schottelius <nico-kernel20060817@schottelius.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Memory bank detection available?
Message-ID: <20060817154815.GA4222@windows95>
References: <20060817144039.GD19497@schottelius.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060817144039.GD19497@schottelius.org>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Is it possible to detect, which memory banks on the mainboard are in use under
> Linux/x86?
In teory it is really if your bios have SMBIOS.

-- 
--------------
Andrew Brukhov
