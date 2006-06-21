Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932077AbWFUVdX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932077AbWFUVdX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 17:33:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932467AbWFUVdX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 17:33:23 -0400
Received: from mail2.sea5.speakeasy.net ([69.17.117.4]:11142 "EHLO
	mail2.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S932077AbWFUVdV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 17:33:21 -0400
Date: Wed, 21 Jun 2006 17:33:18 -0400 (EDT)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@d.namei
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>,
       Eric Paris <eparis@redhat.com>, David Quigley <dpquigl@tycho.nsa.gov>,
       Chris Wright <chrisw@sous-sol.org>,
       Christoph Lameter <clameter@sgi.com>
Subject: [PATCH 0/3] SELinux: movememory & sockcreate updates for -mm
In-Reply-To: <Pine.LNX.4.64.0606211517170.11782@d.namei>
Message-ID: <Pine.LNX.4.64.0606211730540.12872@d.namei>
References: <Pine.LNX.4.64.0606211517170.11782@d.namei>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following is a respin of the patchset sent earlier today, starting 
with:

'Subject: [PATCH 1/3] SELinux: Add security hook definitions for 
setmempolicy'

The only changes are in the first two patches, where the hook names have 
been changed.



-- 
James Morris
<jmorris@namei.org>
