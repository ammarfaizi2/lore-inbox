Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757195AbWKVXzh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757195AbWKVXzh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 18:55:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757198AbWKVXzg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 18:55:36 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:3820 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1757195AbWKVXzf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 18:55:35 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=R4cQh73aPlQpE1gZOOtvztuJUablOTpIEPKL82VTvqUK4t1kXT4IukoVj/fmXUPtk6lAzwarejHZtka0fh2iP6Lu/Dk6u2U2U3fiOj9s6UBLrbXgoCLN8aM+pwo9t1M88nQ+17pIQnzAXqzo/ALfqT6G173OTld6Gi+CK0lkuK4=
Message-ID: <4564E36E.8000405@gmail.com>
Date: Thu, 23 Nov 2006 08:55:26 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Icedove 1.5.0.8 (X11/20061116)
MIME-Version: 1.0
To: Jason Gaston <jason.d.gaston@intel.com>
CC: jgarzik@pobox.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.19-rc6][RESEND] ata_piix: IDE mode SATA patch for
 Intel ICH9
References: <200611221236.16561.jason.d.gaston@intel.com>
In-Reply-To: <200611221236.16561.jason.d.gaston@intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jason Gaston wrote:
> This updated patch adds the Intel ICH9 IDE mode SATA controller DID's.
> 
> Signed-off-by:  Jason Gaston <jason.d.gaston@intel.com>
Acked-by: Tejun Heo <htejun@gmail.com>

-- 
tejun
