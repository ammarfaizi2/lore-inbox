Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262578AbTDXQcL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 12:32:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263731AbTDXQcL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 12:32:11 -0400
Received: from ithilien.qualcomm.com ([129.46.51.59]:5554 "EHLO
	ithilien.qualcomm.com") by vger.kernel.org with ESMTP
	id S262578AbTDXQcJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 12:32:09 -0400
Message-Id: <5.1.0.14.2.20030424093305.08115dc8@unixmail.qualcomm.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Thu, 24 Apr 2003 09:43:42 -0700
To: "David S. Miller" <davem@redhat.com>
From: Max Krasnyansky <maxk@qualcomm.com>
Subject: Re: [BK ChangeSet@1.1118.1.1] new module infrastructure for
  net_proto_family
Cc: acme@conectiva.com.br, linux-kernel@vger.kernel.org, netdev@oss.sgi.com
In-Reply-To: <20030423.202954.85407627.davem@redhat.com>
References: <5.1.0.14.2.20030423182014.07ec6140@unixmail.qualcomm.com>
 <5.1.0.14.2.20030423134636.100e5c60@unixmail.qualcomm.com>
 <20030423.163043.41633133.davem@redhat.com>
 <5.1.0.14.2.20030423182014.07ec6140@unixmail.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 08:29 PM 4/23/2003, David S. Miller wrote:
>   From: Max Krasnyansky <maxk@qualcomm.com>
>   Date: Wed, 23 Apr 2003 18:41:56 -0700
>
>   At 04:30 PM 4/23/2003, David S. Miller wrote:
>   >Your stuff was unacceptable from the start because you didn't put
>   >the ->owner into the protocol ops.
>   But you didn't tell me that. You just said that it's "an ugly hack" without
>   giving any other feedback.
>    
>As you mention, Rusty said this.
>
>   What about this though
>   
>I'm sure Arnaldo will deal with the sys_accept() issues.
>But this is a minor issue, Arnaldo's stuff is architectually
>solid.

:) 

Ok Dave. I'm not sure why you're _completely_ ignoring my arguments.
You should have just said from the beginning that you were going to
ignore what I have to say regarding that issue. At least I wouldn't 
have wasted my time.

Sorry for bugging you.
Max

