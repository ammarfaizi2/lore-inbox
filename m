Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284318AbRLXBDC>; Sun, 23 Dec 2001 20:03:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284314AbRLXBCw>; Sun, 23 Dec 2001 20:02:52 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:19727 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S284304AbRLXBCm>;
	Sun, 23 Dec 2001 20:02:42 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Assigning syscall numbers for testing 
In-Reply-To: Your message of "Sun, 23 Dec 2001 12:06:04 CDT."
             <20011223120604.B19863@redhat.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 24 Dec 2001 12:01:12 +1100
Message-ID: <26616.1009155672@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Dec 2001 12:06:04 -0500, 
Benjamin LaHaise <bcrl@redhat.com> wrote:
>On Sun, Dec 23, 2001 at 04:10:21PM +1100, Keith Owens wrote:
>> I'm glad somebody understands the code :).
>
>There are two directions of binary compatibility: forwads and backwards.  
>Your patch breaks forwards compatibility if used outside the main tree.  Try 
>to understand this.

Too vague, give me an example with real code and effects.

