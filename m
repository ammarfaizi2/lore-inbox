Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964978AbWILHya@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964978AbWILHya (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 03:54:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964975AbWILHya
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 03:54:30 -0400
Received: from wx-out-0506.google.com ([66.249.82.229]:58532 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S964972AbWILHy3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 03:54:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=MMkr510j18dGKPV1zeSZifPO7vB9RNN2rxzLnVdfNnbPUK3iUN2l587Wk2lQ5LAgPelfBkVMxjqHStFSgqhHrjpmb4UA9sIeRrwr3NN1xBh3AH+eauu7RL8qm9jZ+E1O6ilJHV8yAZdPNUtr//htw1886q+u2h8UJ4bbHoMTv1o=
Message-ID: <5444df320609120054l48ce526bi1c34cb790d8f0f5c@mail.gmail.com>
Date: Tue, 12 Sep 2006 10:54:28 +0300
From: "gil ran" <gilrun@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [IPSec] connect: Resource temporarily unavailable
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I am using kernel 2.6.15, and ipsec-tools 0.6.6.
When the first packets excchange starts IKE phase 1 begins, and the
following error is given:
    connect: Resource temporarily unavailable

On 24 Feb 2004 Felipe Alfaro Solana wrote about this issue:
http://lkml.org/lkml/fancy/2004/2/24/73

At the time the answer send by David S. Miller was:
> Known behavior, and it's unlikely to be changing soon as doing the correct
> thing here requires a lot of work.
( http://lkml.org/lkml/2004/2/24/159 )

Is there any progress about this issue?

Gil Ran

Please CC to me, I am not on the list. Thanks.
