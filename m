Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131018AbRBWD1e>; Thu, 22 Feb 2001 22:27:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131041AbRBWD1Y>; Thu, 22 Feb 2001 22:27:24 -0500
Received: from deliverator.sgi.com ([204.94.214.10]:23055 "EHLO
	deliverator.sgi.com") by vger.kernel.org with ESMTP
	id <S131018AbRBWD1T>; Thu, 22 Feb 2001 22:27:19 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: LA Walsh <law@sgi.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: odd memory corrupt problem 
In-Reply-To: Your message of "Thu, 22 Feb 2001 18:46:24 -0800."
             <3A95CF00.4C8A3EBE@sgi.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 23 Feb 2001 14:27:09 +1100
Message-ID: <1256.982898829@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Feb 2001 18:46:24 -0800, 
LA Walsh <law@sgi.com> wrote:
>Any ideas why?  Not that I'm whining, but a good debugger with a 'watch' capability
>would do wonders at this point.

kdb - bpha audit_state dataw

