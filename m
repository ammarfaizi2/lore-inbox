Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275178AbRKHQ1n>; Thu, 8 Nov 2001 11:27:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275270AbRKHQ1X>; Thu, 8 Nov 2001 11:27:23 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:61480 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S275178AbRKHQ1V>; Thu, 8 Nov 2001 11:27:21 -0500
Date: Thu, 8 Nov 2001 11:27:20 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: David Chandler <chandler@grammatech.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Bug Report: Dereferencing a bad pointer
Message-ID: <20011108112720.C24378@redhat.com>
In-Reply-To: <3BE9C261.D7422143@grammatech.com> <20011107184018.A6483@redhat.com> <3BEAA4CF.3B32515F@grammatech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BEAA4CF.3B32515F@grammatech.com>; from chandler@grammatech.com on Thu, Nov 08, 2001 at 10:29:19AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 08, 2001 at 10:29:19AM -0500, David Chandler wrote:
> I get the same result with gcc 3.0.1 and gcc 2.96 (and yes, the relevant
> generated code differs slightly).  I have tried Linus's official 2.4.13+UML
> on UML, but I've not tried 2.4.13-ac8.

Perhaps you should try -ac?

		-ben
