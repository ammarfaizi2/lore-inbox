Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264856AbSLGWje>; Sat, 7 Dec 2002 17:39:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264854AbSLGWje>; Sat, 7 Dec 2002 17:39:34 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:60679 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S264856AbSLGWje>;
	Sat, 7 Dec 2002 17:39:34 -0500
Message-ID: <3DF27A48.2090903@pobox.com>
Date: Sat, 07 Dec 2002 17:46:32 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [RFC][PATCH] net drivers and cache alignment
References: <3DF2781D.3030209@pobox.com> <20021207.144004.45605764.davem@redhat.com>
In-Reply-To: <20021207.144004.45605764.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> Can't the cacheline_aligned attribute be applied to individual
> struct members?  I remember doing this for thread_struct on
> sparc ages ago.


I was hoping someone who knows gcc better than me knew that, and would 
speak up ;-)


