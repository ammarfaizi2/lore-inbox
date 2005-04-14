Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261514AbVDNPCR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261514AbVDNPCR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 11:02:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261516AbVDNPCR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 11:02:17 -0400
Received: from wproxy.gmail.com ([64.233.184.201]:18149 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261514AbVDNPCO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 11:02:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QjzqFbQ6tqlUs8gTxuA0nJKZaarvej08ptKd4EeWSaNsUoh/o6gnbkzxI7uakzMZA4UEOGxRbGXGnWwuzjXwaLGJbQHXSqz7Ec64/olqbbTCzdT2hlKwWjK8cM1VxTBN9aQpSVxooFd1CnbdY3e79EMfeXqPDAD+6RA3a5U0jrE=
Message-ID: <8d64c8f005041408024d1c6843@mail.gmail.com>
Date: Thu, 14 Apr 2005 12:02:14 -0300
From: Jeremy Muise <jeremy.muise@gmail.com>
Reply-To: Jeremy Muise <jeremy.muise@gmail.com>
To: aeriksson@fastmail.fm
Subject: Re: DVD writer and IDE support...
Cc: linux-kernel@vger.kernel.org, lsorense@csclub.uwaterloo.ca
In-Reply-To: <20050414143420.GR521@csclub.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050413181421.5C20E240480@latitude.mynet.no-ip.org>
	 <20050413183722.GQ17865@csclub.uwaterloo.ca>
	 <20050413190756.54474240480@latitude.mynet.no-ip.org>
	 <20050413193924.GN521@csclub.uwaterloo.ca>
	 <20050413205949.E987A240480@latitude.mynet.no-ip.org>
	 <20050414124226.GQ521@csclub.uwaterloo.ca>
	 <20050414133523.6D747240480@latitude.mynet.no-ip.org>
	 <20050414143420.GR521@csclub.uwaterloo.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > It's an AOPEN  DUW1608/ARR
I just thought I should chime in because I have the same burner running
under a 2.6.11 kernel, and using ide-cd. The drive burns just fine, linux
support was good, but I did run into two problems:
1) I had to shop around till I found a brand of DVD-R (I haven't tried RW yet)
    that would work, finally settled on TDK.
2) it failed to write to slower media, I think anything below 4 it had
trouble with

-- 
Jeremy Muise - jeremy.muise@gmail.com
Registered Linux User Number: 374195
