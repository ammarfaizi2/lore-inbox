Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750716AbWDIKZc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750716AbWDIKZc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Apr 2006 06:25:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750719AbWDIKZc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Apr 2006 06:25:32 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:16288 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750716AbWDIKZc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Apr 2006 06:25:32 -0400
Date: Sun, 9 Apr 2006 11:25:22 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Christoph Hellwig <hch@infradead.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       "Serge E. Hallyn" <serue@us.ibm.com>, linux-kernel@vger.kernel.org,
       Kirill Korotaev <dev@sw.ru>, herbert@13thfloor.at, sam@vilain.net,
       xemul@sw.ru, James Morris <jmorris@namei.org>
Subject: Re: [PATCH 3/7] uts namespaces: use init_utsname when appropriate
Message-ID: <20060409102522.GA20276@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	"Serge E. Hallyn" <serue@us.ibm.com>, linux-kernel@vger.kernel.org,
	Kirill Korotaev <dev@sw.ru>, herbert@13thfloor.at, sam@vilain.net,
	xemul@sw.ru, James Morris <jmorris@namei.org>
References: <20060407234815.849357768@sergelap> <20060408045206.EAA8E19B8FF@sergelap.hallyn.com> <m1psjslf1s.fsf@ebiederm.dsl.xmission.com> <20060408202701.GA26403@sergelap.austin.ibm.com> <m164ljjd70.fsf@ebiederm.dsl.xmission.com> <20060409101436.GA20084@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060409101436.GA20084@infradead.org>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

And folks, please remove devel@openvz.org from this thead, it's subscribers
only and gives everyone else nasty bounces.
