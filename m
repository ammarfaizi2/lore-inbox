Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030451AbWAXLJ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030451AbWAXLJ4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 06:09:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030455AbWAXLJ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 06:09:56 -0500
Received: from mx1.redhat.com ([66.187.233.31]:43945 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030451AbWAXLJz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 06:09:55 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1138048952965@2gen.com> 
References: <1138048952965@2gen.com> 
To: David =?us-ascii?Q?=3D=3Fiso-8859-1=3FQ=3FH=3DE4rdeman=3F=3D?= 
	<david@2gen.com>
Cc: linux-kernel@vger.kernel.org, dhowells@redhat.com
Subject: Re: [PATCH 03/04] Add encryption ops to the keyctl syscall 
X-Mailer: MH-E 7.84; nmh 1.1; GNU Emacs 22.0.50.1
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Date: Tue, 24 Jan 2006 11:09:56 +0000
Message-ID: <17791.1138100996@hades.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


David Härdeman <david@2gen.com> wrote:

> and adds encryption as one of the supported ops for in-kernel keys.

Do not forget to update Documentation/keys.txt.

David
