Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751634AbWGZOXJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751634AbWGZOXJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 10:23:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751639AbWGZOXI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 10:23:08 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:60143 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751634AbWGZOXH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 10:23:07 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QHU8lNWz4xsY5ezvh0zqE5H2z49aKvbnrRkDOBKLlApAq9eHROHCXkXbjLGDi3J2EkJAAbZ4o8+KDvB+4BegYzpooAWCBf6fUp9RV/LAsd8kEipm0ouWJZhXcAg85JvJWCy22M4PMxk8NPeWArGrlnBKKn9GoKG5KVunFKySVMw=
Message-ID: <f96157c40607260723u2d629abbiecdcd62554ba4275@mail.gmail.com>
Date: Wed, 26 Jul 2006 14:23:05 +0000
From: "gmu 2k6" <gmu2006@gmail.com>
To: "Michael Buesch" <mb@bu3sch.de>
Subject: Re: hwrng on 82801EB/ER (ICH5/ICH5R) fails rngtest checks
Cc: "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <200607261544.39532.mb@bu3sch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060725222209.0048ed15.akpm@osdl.org>
	 <200607261544.39532.mb@bu3sch.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/26/06, Michael Buesch <mb@bu3sch.de> wrote:

[snip]

> I guess you are running the Intel ICH RNG, right?

yes as can be seen in dmesg and lspic output it's ICH5

[snip]
