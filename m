Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129585AbQKUWEW>; Tue, 21 Nov 2000 17:04:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130766AbQKUWEM>; Tue, 21 Nov 2000 17:04:12 -0500
Received: from [209.143.110.29] ([209.143.110.29]:17673 "HELO
	mail.the-rileys.net") by vger.kernel.org with SMTP
	id <S129585AbQKUWEG>; Tue, 21 Nov 2000 17:04:06 -0500
Message-ID: <3A1AEA47.ECF2D50A@the-rileys.net>
Date: Tue, 21 Nov 2000 16:34:08 -0500
From: David Riley <oscar@the-rileys.net>
X-Mailer: Mozilla 4.74 (Macintosh; U; PPC)
X-Accept-Language: en,pdf
MIME-Version: 1.0
To: David Lang <david.lang@digitalinsight.com>, linux-kernel@vger.kernel.org
Subject: Re: Defective Red Hat Distribution poorly represents Linux
In-Reply-To: <Pine.LNX.4.21.0011211400380.2031-100000@dlang.diginsite.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Lang wrote:
> 
> David, usually when it turns out that Linux finds hardware problems the
> underlying cause is that linux makes more effective use of the component,
> and as such something that was marginal under windows fails under linux as
> the correct timing is used.

This is true.  What I suppose would be the solution is that if faulty
hardware is found, a reduction in performance should be made.  This is
already the case for things like broken PCI BIOS where one can either
set the initialization to work a different way or try to make the
machine autodetect it.  I certainly approve of more effective use of any
given component, but sometimes I think it's better to offer the user a
choice in the case of faulty hardware.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
