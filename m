Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261469AbVCaVsR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261469AbVCaVsR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 16:48:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261521AbVCaVsR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 16:48:17 -0500
Received: from fire.osdl.org ([65.172.181.4]:24804 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261469AbVCaVsO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 16:48:14 -0500
Message-ID: <424C7016.5050404@osdl.org>
Date: Thu, 31 Mar 2005 13:48:06 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Miklos Szeredi <miklos@szeredi.hu>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: build logs for -mm
References: <E1DH7KJ-00023v-00@dorka.pomaz.szeredi.hu>
In-Reply-To: <E1DH7KJ-00023v-00@dorka.pomaz.szeredi.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miklos Szeredi wrote:
> Andrew,
> 
> do I believe correctly that you do automatic builds of -mm for lots of
> architectures?  If yes, is there some place where the output is
> available?  This would be useful for fixing warnings.

The OSDL PLM tool also does automated builds of all -linus
and -mm releases.  2.6.12-rc1-mm4 results are here:

http://www.osdl.org/plm-cgi/plm?module=patch_info&patch_id=4352

However, Andrew's builds are done before these are done (so
are earlier/quicker).  And there are probably some differences
in the tool versions as well.

-- 
~Randy
