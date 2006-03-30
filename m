Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751176AbWC3RMJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751176AbWC3RMJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 12:12:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751314AbWC3RMJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 12:12:09 -0500
Received: from zproxy.gmail.com ([64.233.162.205]:51218 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751176AbWC3RMI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 12:12:08 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Fy1IhvOqc12Xyi6Lg5x2sIdO7CKDICIvLl5mNJfJ/k911sOqwM0bYydg3bDStAiM1lcVm/c/j9Wwq00dMcqr7hbjW0pudSiASV8wbmPuOG7tJSTcAfrZzqgkKrwpYghH5EY/Y5w/AlprwAuppcBGYkcwHc3hWxwBm4emFRnPwZM=
Message-ID: <728201270603300912l1867aa38wb89bcca0df7e307d@mail.gmail.com>
Date: Thu, 30 Mar 2006 11:12:06 -0600
From: "Ram Gupta" <ram.gupta5@gmail.com>
To: "Jon DeVree" <jadevree@mtu.edu>
Subject: Re: How to determine the start of DATA segment
Cc: "linux mailing-list" <linux-kernel@vger.kernel.org>
In-Reply-To: <20060330165225.GA24074@tesla.setec>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <728201270603300837g60eefb65u8b55df910b86f6c4@mail.gmail.com>
	 <20060330165225.GA24074@tesla.setec>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/30/06, Jon DeVree <jadevree@mtu.edu> wrote:
.
>
> I think getrlimit() might be what you are looking for.
> --
> Jon

getrlimit is useful to know the limit set of a resource by setrlimit.
But I am interested in getting the start of DATA segment

Regards
Ram Gupta
