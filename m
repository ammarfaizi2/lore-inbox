Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262449AbUKRD4X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262449AbUKRD4X (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 22:56:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262396AbUKRD4X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 22:56:23 -0500
Received: from wproxy.gmail.com ([64.233.184.203]:60774 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262451AbUKRDy0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 22:54:26 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=aNbQqbf+ZsAj5Sc+IJaQYfBD8CbmLKPV6Nj2EJbTa1GndL8UekmVh6bNub7eoeYCEyvI6D61bwy4tVUxKVlX62xO+flS53aLDr2MpbwHIU3Mz7VeIdMmSB3m2RLQW9Ie87Ub94kzw/TNCVYI0hXG9p+cQMTc+IxW/fj2PQs7V+Y=
Message-ID: <19f134cc041117195353be1e08@mail.gmail.com>
Date: Thu, 18 Nov 2004 09:23:53 +0530
From: Pradeep Anbumani <pradeepdreams@gmail.com>
Reply-To: Pradeep Anbumani <pradeepdreams@gmail.com>
To: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Ack Flooding
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

 I am implementing TCP Daytona, and as my first step I wanna generate
5 acks for each packet received. The ack flooding should be done after
the 3-way handshake.
Can Any one help me out with which function has to be modified.
regards,
Pradeep.A
