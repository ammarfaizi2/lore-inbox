Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311304AbSCLSbI>; Tue, 12 Mar 2002 13:31:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311308AbSCLSat>; Tue, 12 Mar 2002 13:30:49 -0500
Received: from smtp-send.myrealbox.com ([192.108.102.143]:774 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id <S311304AbSCLSah>; Tue, 12 Mar 2002 13:30:37 -0500
Subject: Re: [patch] ns83820 0.17
From: "Trever L. Adams" <tadams-lists@myrealbox.com>
To: "David S. Miller" <davem@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20020312.101713.106542707.davem@redhat.com>
In-Reply-To: <51A3E836-35A8-11D6-A4A8-000393843900@metaparadigm.com>
	<20020312.031509.53067416.davem@redhat.com>
	<1015956757.4220.3.camel@aurora> 
	<20020312.101713.106542707.davem@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 12 Mar 2002 13:31:07 -0500
Message-Id: <1015957871.4220.6.camel@aurora>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-03-12 at 13:17, David S. Miller wrote:
>    From: "Trever L. Adams" <tadams-lists@myrealbox.com>
>    Date: 12 Mar 2002 13:12:32 -0500
>    
>    David, you believe we don't need NAPI.
> 
> I said we don't need NAPI for just bandwidth streams, you mention
> routing which is specifically the case I mention that NAPI is good for
> (high packet rates).
> 

My apologies.  I have been trying to follow the conversation, but came
in, I believe, quite late.  I only saw the comments about NAPI and
bandwidth last night.

Thank you for clear that up.

Trever Adams

