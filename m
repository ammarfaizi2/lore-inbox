Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129038AbQKFL4i>; Mon, 6 Nov 2000 06:56:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129057AbQKFL42>; Mon, 6 Nov 2000 06:56:28 -0500
Received: from zeus.kernel.org ([209.10.41.242]:17671 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129038AbQKFL4S>;
	Mon, 6 Nov 2000 06:56:18 -0500
Date: Mon, 6 Nov 2000 11:51:10 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: Dominik Kubla <dominik.kubla@uni-mainz.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        sct@redhat.com, sbest@us.ibm.com, linuxjfs@us.ibm.com
Subject: Re: ext3 vs. JFS file locations...
Message-ID: <20001106115110.D17728@redhat.com>
In-Reply-To: <20001105024621.A29327@uni-mainz.de> <200011050253.eA52rfc515962@saturn.cs.uml.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <200011050253.eA52rfc515962@saturn.cs.uml.edu>; from acahalan@cs.uml.edu on Sat, Nov 04, 2000 at 09:53:41PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Nov 04, 2000 at 09:53:41PM -0500, Albert D. Cahalan wrote:
> 
> The journalling layer for ext3 is not a filesystem by itself.
> It is generic journalling code. So, even if IBM did not have
> any jfs code, the name would be wrong.

Indeed, and the jfs layer will be renamed "jbd" at some point (for
"journaling block device" support).

Cheers,
 Stephen
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
