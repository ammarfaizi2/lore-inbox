Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751464AbWIFVFw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751464AbWIFVFw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 17:05:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751480AbWIFVFw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 17:05:52 -0400
Received: from nz-out-0102.google.com ([64.233.162.193]:5205 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751464AbWIFVFu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 17:05:50 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=dCWjv80DjLUtK5qReA1P29PqaafdvllKBgHMQEHxKL6jtiW0aMhJBRMGIPdnFMHjgrvZCCSq5VtBYVh6qso0ofEqbl13pNq6R7tNnev7cDy8zTYsDS+lWEMH1KLocU1sovhJlQ95tlgUtGMEVbJ27EDQHprDJzYufjl1pynqoHk=
Message-ID: <ea0b05b30609061405p708e44c5nc08446b7f8959fe8@mail.gmail.com>
Date: Wed, 6 Sep 2006 14:05:49 -0700
From: Ethan <thesyntheticsophist@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: File corruption with 2940U2 SCSI card and aic7xxx driver. [SOLVED]
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I would actually say that is very consistent with hardware
> incompatibility between the card and motherboard. I'd still like to know
> what the current kernels do
>

It turns out you were right, Alan.  I swapped the motherboard for a
new one and everything works perfectly now.  I think the motherboard
was going bad as it was starting to get flaky about detecting some of
the other hardware.

Thanks for your suggestions Alan and Ray.

--Ethan
