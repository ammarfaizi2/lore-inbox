Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030335AbVKCPVT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030335AbVKCPVT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 10:21:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030341AbVKCPVS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 10:21:18 -0500
Received: from xproxy.gmail.com ([66.249.82.203]:58249 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030335AbVKCPVR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 10:21:17 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NSM4dTsItQWUSnaxyCgaCriNf9/xYqFrgervHvgq2cTzcsgm6y6Pq2wrvMD2cTrFt4jUB+Tljx09jWvTBNmUXMMUqnR74IYtqHUvIHFsxZ3LMziMeC2UxSdllBzU9DcX+97GHhLJ3kOQAOpyDW/EKg3jEm4X4DmsWoqJspdGY1M=
Message-ID: <afcef88a0511030721g68ddf71bjf02397abcd8da30@mail.gmail.com>
Date: Thu, 3 Nov 2005 09:21:16 -0600
From: Michael Thompson <michael.craig.thompson@gmail.com>
To: Phillip Hellewell <phillip@hellewell.homeip.net>
Subject: Re: [PATCH 1/12: eCryptfs] Makefile and Kconfig
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       mike@halcrow.us, mhalcrow@us.ibm.com, mcthomps@us.ibm.com,
       yoder1@us.ibm.com
In-Reply-To: <20051103034207.GA3005@sshock.rn.byu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051103033220.GD2772@sshock.rn.byu.edu>
	 <20051103034207.GA3005@sshock.rn.byu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/2/05, Phillip Hellewell <phillip@hellewell.homeip.net> wrote:
> These patches modify fs/Makefile and fs/Kconfig to provide build
> support for eCryptfs.
>
> Signed off by: Phillip Hellewell <phillip@hellewell.homeip.net>
> Signed off by: Michael Halcrow <mhalcrow@us.ibm.com>
> Signed off by: Michael Thompson <mmcthomps@us.ibm.com>

That should read:
Signed off by: Michael Thompson <mcthomps@us.ibm.com>

(Extra m), ah well :)
