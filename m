Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262157AbUK0FBq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262157AbUK0FBq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 00:01:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262172AbUK0ESH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 23:18:07 -0500
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:20155 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S262212AbUK0EHE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 23:07:04 -0500
Message-ID: <41A7FCFB.9000704@nortelnetworks.com>
Date: Fri, 26 Nov 2004 22:05:15 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tonnerre <tonnerre@thundrix.ch>
CC: David Howells <dhowells@redhat.com>, torvalds@osdl.org, hch@infradead.org,
       matthew@wil.cx, dwmw2@infradead.org, aoliva@redhat.com,
       linux-kernel@vger.kernel.org, libc-hacker@sources.redhat.com
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
References: <19865.1101395592@redhat.com> <20041127042942.GA10774@pauli.thundrix.ch>
In-Reply-To: <20041127042942.GA10774@pauli.thundrix.ch>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tonnerre wrote:

> Fnord alert: you're trying to change the API and the ABI of Linux.

No he's not.  He's changing the location where the API is defined, and the ABI 
doesn't change a bit.

Existing binaries will continue to run without modification.

Chris
