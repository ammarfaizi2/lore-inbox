Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751482AbWJRQYt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751482AbWJRQYt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 12:24:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751492AbWJRQYs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 12:24:48 -0400
Received: from nz-out-0102.google.com ([64.233.162.207]:56901 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751466AbWJRQYq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 12:24:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=PTKClbvwmVxUPnnDaK/lxKZinjiB51lAeE/2qC5L37HCXkSCDmtfowCxcY1A5Ygielr3DQbByJREV00LXcEemzEGU1BF4RiECQ+ZrVDRYsmjE6xvMLEoVlLKZH5MZjueAgvlfQS96le08kizlZTZ5BbBt7CLjpcLzX2I6+qcn0s=
Message-ID: <45365545.9000703@gmail.com>
Date: Thu, 19 Oct 2006 01:24:37 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060928)
MIME-Version: 1.0
To: Jesse Brandeburg <jesse.brandeburg@gmail.com>
CC: Joe Jin <lkmaillist@gmail.com>, linux-ide@vger.kernel.org,
       lkml <linux-kernel@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata: skip reset on bus not a device
References: <215036450609292206pd16c7cxa1c5c77ee52c050e@mail.gmail.com>	 <451E7BD2.7020002@gmail.com>	 <215036450609301849h64551749uf6b4a3e48c57fe15@mail.gmail.com>	 <4529BCC4.8060906@gmail.com>	 <215036450610082354q34b906bdp54a3b9cee52a5855@mail.gmail.com>	 <4529F391.3030504@gmail.com> <20061009070652.GE10832@htj.dyndns.org> <4807377b0610171613i5df25ddekb8c470d767a11005@mail.gmail.com>
In-Reply-To: <4807377b0610171613i5df25ddekb8c470d767a11005@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Brandeburg wrote:
> Is this patch going to go upstream?  I've been testing 2.6.18 on a
> couple different systems and seen the same issue.  I haven't tested
> the patch yet.

The patch is pending review.

http://thread.gmane.org/gmane.linux.ide/13408/focus=13439

-- 
tejun
