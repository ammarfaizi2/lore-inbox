Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265142AbTGCLGR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 07:06:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265153AbTGCLGR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 07:06:17 -0400
Received: from holomorphy.com ([66.224.33.161]:57789 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S265144AbTGCLGQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 07:06:16 -0400
Date: Thu, 3 Jul 2003 04:20:26 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Dumitru Ciobarcianu <Dumitru.Ciobarcianu@iNES.RO>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.5.74-mm1 (p4-clockmod does not compile)
Message-ID: <20030703112026.GO26348@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Dumitru Ciobarcianu <Dumitru.Ciobarcianu@iNES.RO>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
References: <20030703023714.55d13934.akpm@osdl.org> <1057229141.1479.16.camel@LNX.iNES.RO> <20030703110713.GN26348@holomorphy.com> <1057231068.1479.18.camel@LNX.iNES.RO>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1057231068.1479.18.camel@LNX.iNES.RO>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 03, 2003 at 02:17:48PM +0300, Dumitru Ciobarcianu wrote:
> I had to mannually change the file (the patch was giving rejects), but
> it compiles now.

Great! Could you send back the diff? (or alternatively, the file
contents if you didn't preserve the old contents) so I can send the
proper diff upstream?


-- wli
