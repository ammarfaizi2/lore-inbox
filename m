Return-Path: <linux-kernel-owner+w=401wt.eu-S932931AbWL0GdU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932931AbWL0GdU (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 01:33:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932934AbWL0GdU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 01:33:20 -0500
Received: from ag-out-0708.google.com ([72.14.246.249]:5320 "EHLO
	ag-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932931AbWL0GdT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 01:33:19 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=r5Z+20HXCm+srf6moziMxVAKYeXP1QYTZxiGgmsAoHEL86uvWG6unkwqqnqaCjosP5sv4WHHLaCn3KsVPzxYENhCH3SrHntIdNWsIABJegEJc94qSjREhBwMSd4f2UpjBM6kcxmDg6+QzU0rYepcK3G8Y/QQdk7z5ngVCjmLFsc=
Message-ID: <4592139E.9090301@gmail.com>
Date: Wed, 27 Dec 2006 15:33:02 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Icedove 1.5.0.9 (X11/20061220)
MIME-Version: 1.0
To: Ioan Ionita <opslynx@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: PATA_SIS and SIS 5513
References: <df47b87a0612211854w40f8ee3akb2a2721070878341@mail.gmail.com>
In-Reply-To: <df47b87a0612211854w40f8ee3akb2a2721070878341@mail.gmail.com>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ioan Ionita wrote:
> pata_sis will not work with my CD-ROM
> 
> dmesg output when trying to mount a cd-rom:

Please post full dmesg including all boot messages.

-- 
tejun
