Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132413AbREHM3M>; Tue, 8 May 2001 08:29:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132392AbREHM3C>; Tue, 8 May 2001 08:29:02 -0400
Received: from t2.redhat.com ([199.183.24.243]:28149 "HELO
	executor.cambridge.redhat.com") by vger.kernel.org with SMTP
	id <S132318AbREHM2x>; Tue, 8 May 2001 08:28:53 -0400
To: gabriel finch <gfinch@blueyonder.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.4 rwsem make error, please somebody take a look !! 
In-Reply-To: Your message of "Tue, 08 May 2001 11:15:14 BST."
             <3AF7C732.C2072776@blueyonder.co.uk> 
Date: Tue, 08 May 2001 13:28:50 +0100
Message-ID: <26740.989324930@warthog.cambridge.redhat.com>
From: David Howells <dhowells@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


What arch are you compiling for? i386?

> > When I compiled bzImage (using .config from 2.2.3) I got the following
> > errors:

Did you run one of the "make config" commands before building the kernel? You
may need to do this to flush the changes from arch/*/config.in into .config.

David
